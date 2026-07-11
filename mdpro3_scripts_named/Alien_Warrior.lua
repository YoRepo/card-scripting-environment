--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Alien Warrior  (ID: 98719226)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level: 4
-- ATK 1800 | DEF 1000
-- Setcode: 0xc, 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the Graveyard, place 2 A-Counters on the monster
-- that destroyed it.
-- (If a monster with an A-Counter battles an "Alien" monster, it loses 300 ATK and DEF for each
-- A-Counter during damage calculation only.)
--[[ __CARD_HEADER_END__ ]]

--エーリアン・ウォリアー
function c98719226.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98719226,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c98719226.ctcon)
	e1:SetOperation(c98719226.ctop)
	c:RegisterEffect(e1)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c98719226.adcon)
	e2:SetTarget(c98719226.adtg)
	e2:SetValue(c98719226.adval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
c98719226.counter_add_list={0x100e}
function c98719226.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c98719226.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetReasonCard()
	if tc:IsFaceup() and tc:IsRelateToBattle() then
		tc:AddCounter(0x100e,2)
	end
end
function c98719226.adcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c98719226.adtg(e,c)
	local bc=c:GetBattleTarget()
	return bc and c:GetCounter(0x100e)~=0 and bc:IsSetCard(0xc)
end
function c98719226.adval(e,c)
	return c:GetCounter(0x100e)*-300
end
