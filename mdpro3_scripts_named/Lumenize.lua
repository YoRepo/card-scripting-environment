--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Lumenize  (ID: 57115864)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack: Target the attacking monster; negate the attack, and
-- 1 face-up LIGHT monster you control gains ATK equal to that target's ATK, until your next End Phase.
--[[ __CARD_HEADER_END__ ]]

--光子化
function c57115864.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c57115864.condition)
	e1:SetTarget(c57115864.target)
	e1:SetOperation(c57115864.activate)
	c:RegisterEffect(e1)
end
function c57115864.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c57115864.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e)
		and Duel.IsExistingMatchingCard(c57115864.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetTargetCard(tg)
end
function c57115864.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c57115864.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c57115864.filter,tp,LOCATION_MZONE,0,1,1,nil)
		local ac=g:GetFirst()
		if ac then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(tc:GetAttack())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
			ac:RegisterEffect(e1)
		end
	end
end
