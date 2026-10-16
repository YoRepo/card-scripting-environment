--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Amazoness Swordmaster  (ID: 101403032)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2600 | DEF 2200
-- Setcode: 0x4 (Amazoness)
--
-- Materials: 2 "Amazoness" monsters
--
-- Effect Text:
-- You can only use the ①st and ③rd effects of this card's name each once per turn.
-- ① If this card is Fusion Summoned: You can Special Summon 1 Level 4 or lower "Amazoness" monster
-- from your Deck.
-- ② When your "Amazoness" monster destroys an opponent's monster by battle: You can draw 1 card.
-- ③ (Quick Effect): You can Tribute 1 monster, then target 1 Effect Monster on the field; it loses
-- 500 ATK, also its effects are negated.
--[[ __CARD_HEADER_END__ ]]

--Amazoness Swordmaster
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material: 2 "Amazoness" monsters
	--(IsFusionSetCard, so material-setcode changes count, cf. Amazoness Augusta / Artmage Non-Finito)
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x4),2,true)
	--(1) if Fusion Summoned: Special Summon 1 Level 4 or lower "Amazoness" monster from your Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(2) when your "Amazoness" monster destroys an opponent's monster by battle: draw 1 card
	--(not in the once-per-turn clause, so no count limit)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.drcon)
	e2:SetTarget(s.drtg)
	e2:SetOperation(s.drop)
	c:RegisterEffect(e2)
	--(3) (Quick Effect) Tribute 1 monster, then target 1 Effect Monster on the field; it loses 500 ATK,
	--also its effects are negated (changes ATK, so usable in the Damage Step, cf. Tri-Edge Levia / Trivikarma)
	--(count code id+o: the once-per-turn clause lists only (1) and (3), numbered consecutively, cf. Morgana the Witch of Eyes)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(aux.dscon)
	e3:SetCost(s.discost)
	e3:SetTarget(s.distg)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
end
--(1)
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
--1 Level 4 or lower "Amazoness" monster from the Deck (filter cf. Queen's Pawn); IsLevelBelow is already false at
--level 0, so Spells/Traps are excluded either way; TYPE_MONSTER is kept per house convention (D)
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x4) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
--does not need this card on the field at resolution (cf. Amazoness Augusta)
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
--(2)
--your face-up "Amazoness" monster (this card included: no "other") that battled an opponent's monster and is
--still on the field, in either player's turn (cf. Myutant Clash / Queen Azamina); eg is checked with IsExists
--so the result does not depend on eg order
function s.drfilter(c,tp)
	return c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE) and c:IsControler(tp)
		and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsSetCard(0x4)
end
function s.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.drfilter,1,nil,tp)
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
--(3)
--a face-up Effect Monster to which at least one half still applies (cf. Pitknight Earlie)
function s.disfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and (c:GetAttack()>0 or aux.NegateEffectMonsterFilter(c))
end
--"then target": the Tributed monster (this card included) cannot be the target (cf. Tenyinfinity / Golden Dragon Summoner)
function s.costfilter(c,tp)
	return Duel.IsExistingTarget(s.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,s.costfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,s.costfilter,1,1,nil,tp)
	--spends Lair of Darkness's extra Tribute if an opponent's monster was chosen (cf. Mitsurugi Magatama)
	aux.UseExtraReleaseCount(g,tp)
	Duel.Release(g,REASON_COST)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,s.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
--"also": both halves apply independently; no duration is printed, so both are permanent (RESETS_STANDARD with no
--phase reset, cf. Dragunity Arma Gram / Heretical Phobos Covos; Tri-Edge Levia's "until the end of this turn" is printed).
--CANNOT_DISABLE on all three (cf. Tri-Edge Levia) so that, if this card targets itself, its own negation does not
--switch off the -500 or the negation. Does not need this card on the field (it may have been Tributed)
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e3)
	end
end
