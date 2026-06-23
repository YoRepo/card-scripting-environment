--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Impaler  (ID: 211100)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Illusion
-- Level 9
-- ATK 2600 | DEF 2000
-- Setcode: 0x95c (Crimsonheart)
--
-- Materials: 1 Tuner + 1+ non-Tuner monsters
--
-- Effect Text:
-- You can only use each effect of "Crimsonheart Impaler" once per turn.
-- (1) If this card is Special Summoned from the Extra Deck: You can target 2 cards on the field,
-- including 1 "Crimsonheart" Spell/Trap; negate their effects, then destroy them.
-- (2) At the Start of the Damage Step, if this card battles an opponent's monster: You can send both
-- battling monsters to the GY, then, if "Inverted Palace Crimsonheart" is face-up on the field, you
-- can Special Summon this card.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Impaler
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211040)
	--synchro summon: 1 Tuner + 1 or more non-Tuner monsters
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--(1) if SS'd from Extra Deck: target 2 cards (incl. 1 "Crimsonheart" S/T); negate effects, then destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.negcon)
	e1:SetTarget(s.negtg)
	e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
	--(2) at Start of Damage Step, if battling opp monster: send both to GY, then maybe SS this card
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
--(1)
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_EXTRA)
end
function s.stfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x95c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.gcheck(g)
	return g:IsExists(s.stfilter,1,nil)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local rg=Duel.GetMatchingGroup(Card.IsCanBeEffectTarget,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if chk==0 then return rg:CheckSubGroup(s.gcheck,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=rg:SelectSubGroup(tp,s.gcheck,false,2,2)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetsRelateToChain():Filter(Card.IsOnField,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.BreakEffect()
	Duel.Destroy(g,REASON_EFFECT)
end
--(2)
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsControler(1-tp)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsRelateToBattle() end
	local g=Group.FromCards(c,bc)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,2,0,0)
end
function s.ipfilter(c)
	return c:IsFaceup() and c:IsCode(211040)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not (c:IsRelateToBattle() and bc and bc:IsRelateToBattle()) then return end
	local g=Group.FromCards(c,bc)
	Duel.SendtoGrave(g,REASON_EFFECT)
	if c:IsLocation(LOCATION_GRAVE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.ipfilter,tp,LOCATION_FZONE,LOCATION_FZONE,1,nil)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
