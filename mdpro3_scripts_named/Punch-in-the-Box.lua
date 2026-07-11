--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Punch-in-the-Box  (ID: 31077447)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent's monster declares an attack while they control 2 or more monsters: Target the
-- attacking monster; negate that attack, and if you do, send 1 other monster they control to the
-- Graveyard, then the targeted monster loses ATK equal to the original ATK or DEF (whichever is
-- higher, your choice if tied) of the sent monster in the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--びっくり箱
function c31077447.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c31077447.condition)
	e1:SetTarget(c31077447.target)
	e1:SetOperation(c31077447.activate)
	c:RegisterEffect(e1)
end
function c31077447.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
end
function c31077447.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttacker()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c31077447.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not Duel.NegateAttack() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,tc)
	local sc=g:GetFirst()
	if sc and Duel.SendtoGrave(sc,REASON_EFFECT)~=0 and sc:IsLocation(LOCATION_GRAVE) then
		Duel.BreakEffect()
		local val=math.max(0,sc:GetAttack(),sc:GetDefense())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-val)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
