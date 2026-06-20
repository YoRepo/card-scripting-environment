--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 燎星之天火流星神  (ID: 75713017)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level 8
-- ATK 2800 | DEF 2000
--
-- Effect Text:
-- ①：这张卡的攻击破坏主要怪兽区域的对方怪兽时，丢弃1张手卡才能发动。这张卡可以继续攻击。直到下个回合的结束时，那只怪兽存在过的区域不能使用。
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
