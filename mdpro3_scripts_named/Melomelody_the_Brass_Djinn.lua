--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 管魔人 迷迷旋律  (ID: 88942504)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fiend
-- Rank 3
-- ATK 1400 | DEF 1600
-- Setcode: 109
--
-- Effect Text:
-- 3星怪兽×2
-- 1回合1次，把这张卡1个超量素材取除，选择自己场上1只名字带有「魔人」的超量怪兽才能发动。这个回合，选择的怪兽在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--管魔人メロメロメロディ
function c88942504.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88942504,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c88942504.condition)
	e1:SetCost(c88942504.cost)
	e1:SetTarget(c88942504.target)
	e1:SetOperation(c88942504.operation)
	c:RegisterEffect(e1)
end
function c88942504.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c88942504.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c88942504.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x6d) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c88942504.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c88942504.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88942504.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c88942504.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c88942504.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
