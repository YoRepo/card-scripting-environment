--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 清透堕恶骑士  (ID: 70095046)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2300 | DEF 1100
--
-- Effect Text:
-- 这张卡可以把有「清透世界」的卡名记述的1只怪兽解放作上级召唤。
-- ①：这张卡的攻击力上升对方场上的怪兽的最高原本攻击力数值。
-- ②：只要这张卡在怪兽区域存在，「清透世界」的效果对自己不适用。
-- ③：只要上级召唤的这张卡在怪兽区域存在，对方不能把持有比这张卡低的攻击力的场上的特殊召唤的怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--クリアー・ヴィシャス・ナイト
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,33900648)
	--summon proc
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(s.otcon)
	e1:SetOperation(s.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE,EFFECT_FLAG2_WICKED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(s.adval)
	c:RegisterEffect(e3)
	--unaffected
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,0)
	e4:SetCode(97811903)
	c:RegisterEffect(e4)
	--cannot activate
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,1)
	e5:SetCondition(s.thcon)
	e5:SetValue(s.limval)
	c:RegisterEffect(e5)
end
function s.otfilter(c)
	return aux.IsCodeListed(c,33900648)
end
function s.otcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(s.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,mg)
end
function s.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(s.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function s.adval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,e:GetOwnerPlayer(),0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetBaseAttack)
		return val
	end
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function s.limval(e,re,rp)
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_MZONE) and re:IsActiveType(TYPE_MONSTER)
		and rc:IsSummonType(SUMMON_TYPE_SPECIAL)
		and rc:GetAttack()<e:GetHandler():GetAttack()
end
