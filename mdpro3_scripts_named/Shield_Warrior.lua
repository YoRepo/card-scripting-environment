--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Shield Warrior  (ID: 95360850)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 800 | DEF 1600
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- During damage calculation, in either player's turn: You can banish this card from your Graveyard;
-- monsters you control cannot be destroyed by this battle.
--[[ __CARD_HEADER_END__ ]]

--シールド・ウォリアー
function c95360850.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95360850,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c95360850.atkcon)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c95360850.atkop)
	c:RegisterEffect(e1)
end
function c95360850.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	return tc and tc:IsControler(tp)
end
function c95360850.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
