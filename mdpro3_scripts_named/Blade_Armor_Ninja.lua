--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 机甲忍者 刃心  (ID: 82944432)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Warrior
-- Rank 4
-- ATK 2200 | DEF 1000
-- Setcode: 43
--
-- Effect Text:
-- 战士族4星怪兽×2
-- ①：1回合1次，把这张卡1个超量素材取除，以自己场上1只「忍者」怪兽为对象才能发动。这个回合，那只怪兽在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--機甲忍者ブレード・ハート
function c82944432.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),4,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82944432,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c82944432.condition)
	e1:SetCost(c82944432.cost)
	e1:SetTarget(c82944432.target)
	e1:SetOperation(c82944432.operation)
	c:RegisterEffect(e1)
end
function c82944432.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c82944432.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c82944432.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c82944432.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c82944432.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82944432.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c82944432.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c82944432.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
