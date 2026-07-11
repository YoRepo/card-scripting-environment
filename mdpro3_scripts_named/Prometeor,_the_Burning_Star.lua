--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Prometeor, the Burning Star  (ID: 75713017)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level: 8
-- ATK 2800 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this attacking card destroys a monster in your opponent's Main Monster Zone: You can discard 1
-- card; this card can attack again in a row, also the zone that monster was in cannot be used until
-- the end of the next turn.
--[[ __CARD_HEADER_END__ ]]

--燎星のプロメテオロン
function c75713017.initial_effect(c)
	--extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75713017,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c75713017.atcon)
	e1:SetCost(c75713017.atcost)
	e1:SetOperation(c75713017.atop)
	c:RegisterEffect(e1)
end
function c75713017.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc then return false end
	local seq=bc:GetPreviousSequence()
	e:SetLabel(seq)
	return Duel.GetAttacker()==c and aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and seq<5 and c:IsChainAttackable(0)
end
function c75713017.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_DISCARD+REASON_COST)
end
function c75713017.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
	local seq=e:GetLabel()
	local val=aux.SequenceToGlobal(1-tp,LOCATION_MZONE,seq)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(val)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
