--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 大薰风凤凰  (ID: 2766877)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Pyro
-- Rank 2
-- ATK 1500 | DEF 1100
-- Setcode: 16
--
-- Effect Text:
-- 2星怪兽×2
-- 1回合1次，把这张卡1个超量素材取除，选择自己场上表侧表示存在的1只风属性怪兽才能发动。这个回合，选择的怪兽在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--ダイガスタ・フェニクス
function c2766877.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2766877,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c2766877.condition)
	e1:SetCost(c2766877.cost)
	e1:SetTarget(c2766877.target)
	e1:SetOperation(c2766877.operation)
	c:RegisterEffect(e1)
end
function c2766877.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c2766877.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c2766877.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c2766877.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c2766877.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2766877.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c2766877.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2766877.operation(e,tp,eg,ep,ev,re,r,rp)
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
