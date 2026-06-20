--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 嵌合要塞龙  (ID: 79229522)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「电子龙」＋机械族怪兽1只以上
-- 把自己·对方场上的上记的卡送去墓地的场合才能从额外卡组特殊召唤。这张卡不能作为融合素材。
-- ①：这张卡的原本攻击力变成作为这张卡的融合素材的怪兽数量×1000。
--[[ __CARD_HEADER_END__ ]]

--キメラテック・フォートレス・ドラゴン
function c79229522.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFunRep(c,70095154,c79229522.mfilter,1,127,true,true)
	aux.AddContactFusionProcedure(c,c79229522.cfilter,LOCATION_ONFIELD,LOCATION_ONFIELD,c79229522.sprop(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c79229522.splimit)
	c:RegisterEffect(e1)
	--cannot be fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
c79229522.material_setcode=0x1093
function c79229522.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c79229522.mfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsType(TYPE_MONSTER)
end
function c79229522.cfilter(c,fc)
	return c:IsAbleToGraveAsCost() and (c:IsControler(fc:GetControler()) or c:IsFaceup())
end
function c79229522.sprop(c)
	return	function(g)
				Duel.SendtoGrave(g,REASON_COST)
				--spsummon condition
				local ct=g:GetCount()
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_BASE_ATTACK)
				e1:SetReset(RESET_EVENT+0xff0000)
				e1:SetValue(ct*1000)
				c:RegisterEffect(e1)
			end
end
