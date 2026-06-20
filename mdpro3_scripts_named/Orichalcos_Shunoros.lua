--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 山铜合神偶  (ID: 7634581)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Machine
-- Level 10
-- ATK ? | DEF 0
--
-- Effect Text:
-- 这张卡不能通常召唤。这张卡的①的效果可以特殊召唤。
-- ①：自己的通常怪兽被战斗破坏的场合，伤害步骤结束时才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡的攻击力上升对方场上的怪兽数量×1000。
-- ③：只要这张卡在怪兽区域存在，场上的4星通常怪兽不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--オレイカルコス・シュノロス
function c7634581.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7634581,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c7634581.spcon)
	e1:SetTarget(c7634581.sptg)
	e1:SetOperation(c7634581.spop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c7634581.value)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c7634581.efilter)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c7634581.value(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*1000
end
function c7634581.efilter(e,c)
	return c:IsType(TYPE_NORMAL) and c:IsLevel(4)
end
function c7634581.cfilter(c,tp)
	return bit.band(c:GetPreviousTypeOnField(),TYPE_NORMAL)~=0 and c:IsPreviousControler(tp)
end
function c7634581.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c7634581.cfilter,1,nil,tp)
end
function c7634581.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c7634581.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	end
end
