--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Bujingi Crow  (ID: 89662736)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level: 4
-- ATK 1700 | DEF 800
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Beast-Warrior-Type "Bujin" monster you control is targeted for an attack by an opponent's
-- monster: You can send this card from your hand to the Graveyard; negate the attack, and if you do,
-- inflict damage to your opponent equal to half the attacker's ATK.
-- You can only use the effect of "Bujingi Crow" once per turn.
--[[ __CARD_HEADER_END__ ]]

--武神器－ヤタ
function c89662736.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89662736,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89662736)
	e1:SetCondition(c89662736.nacon)
	e1:SetCost(c89662736.nacost)
	e1:SetTarget(c89662736.natg)
	e1:SetOperation(c89662736.naop)
	c:RegisterEffect(e1)
end
function c89662736.nacon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp) and at:IsFaceup() and at:IsSetCard(0x88) and at:IsRace(RACE_BEASTWARRIOR)
end
function c89662736.nacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c89662736.natg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsOnField() end
	local dam=math.floor(Duel.GetAttacker():GetAttack()/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c89662736.naop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.NegateAttack() then
		Duel.Damage(1-tp,math.floor(a:GetAttack()/2),REASON_EFFECT)
	end
end
