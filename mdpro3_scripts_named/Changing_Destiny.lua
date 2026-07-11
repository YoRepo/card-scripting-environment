--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Changing Destiny  (ID: 24673894)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack: Target the attacking monster; negate the attack, and
-- if you do, change it to Defense Position and it cannot change its battle position while it is
-- face-up on the field.
-- Then, your opponent chooses 1 of these effects.
-- ● You (the opponent of this card's activator) gain LP equal to half the target's ATK.
-- ● Your opponent (the activator of this card) takes damage equal to half the target's ATK.
--[[ __CARD_HEADER_END__ ]]

--チェンジ・デステニー
function c24673894.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c24673894.condition)
	e1:SetTarget(c24673894.target)
	e1:SetOperation(c24673894.activate)
	c:RegisterEffect(e1)
end
function c24673894.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c24673894.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttacker()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsLocation(LOCATION_MZONE) and tc:IsAttackPos()
		and tc:IsCanChangePosition() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c24673894.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and Duel.NegateAttack() and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		Duel.BreakEffect()
		local val=tc:GetAttack()/2
		local op=Duel.SelectOption(1-tp,aux.Stringid(24673894,0),aux.Stringid(24673894,1))
		if op==0 then Duel.Recover(1-tp,math.ceil(val),REASON_EFFECT)
		else Duel.Damage(tp,math.floor(val),REASON_EFFECT) end
	end
end
