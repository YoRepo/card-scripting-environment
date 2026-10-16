--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Amazoness Fighter - Instant Kill Dance  (ID: 101403006)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1300
-- Setcode: 0x4 (Amazoness)
--
-- Effect Text:
-- You can only use the ①st, ②nd, and ③rd effects of this card's name each once per turn.
-- ① If this card is added to your hand, except by drawing it: You can Special Summon it.
-- ② If this card is Normal or Special Summoned: You can Set 1 Spell/Trap from your Deck that mentions
-- "Harpie Lady".
-- ③ During damage calculation, if your "Amazoness" monster battles an opponent's monster: You can make
-- both battling monsters unable to be destroyed by that battle, also you take no battle damage from
-- it.
--[[ __CARD_HEADER_END__ ]]

--Amazoness Fighter - Instant Kill Dance
local s,id,o=GetID()
function s.initial_effect(c)
	--names "Harpie Lady" ((2) Sets a Spell/Trap that mentions it); this also makes it a monster that mentions
	--"Harpie Lady" for Elegant Tri-Mirror
	aux.AddCodeList(c,76812113)
	--(1) if added to your hand, except by drawing it: Special Summon it
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(2) if Normal or Special Summoned: Set 1 Spell/Trap that mentions "Harpie Lady" from your Deck
	--(both registrations share one count code, cf. Diabellstar the Black Witch / Amazoness War Chief)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.settg)
	e2:SetOperation(s.setop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--(3) during damage calculation, if your "Amazoness" monster battles an opponent's monster: both battling
	--monsters cannot be destroyed by that battle, also you take no battle damage from it
	--(a Trigger, not a Quick Effect: no "(Quick Effect)" label, cf. Performapal Odd-Eyes Minitaurus)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,id+o*2)
	e4:SetCondition(s.indcon)
	e4:SetOperation(s.indop)
	c:RegisterEffect(e4)
end
--(1)
--a draw by a card effect is also REASON_DRAW, so it is excluded too (cf. Snake-Eyes Poplar)
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_DRAW)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
--(2)
--Spell/Trap that mentions "Harpie Lady": new cards register it (aux.AddCodeList); the older ones that name it register only
--"Harpie Lady Sisters" or nothing, so they are listed by code: "Alluring Mirror Split", "Cyber Shield", "Elegant Egotist",
--"Harpie's Feather Rest", "Harpie Lady Phoenix Formation", "Harpies' Hunting Ground", "Hysteric Party"
function s.hlstfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (aux.IsCodeListed(c,76812113)
		or c:IsCode(92881099,63224564,90219263,39275698,86308219,75782277,77778835))
end
--IsSSetable also passes a Field Spell when the Spell & Trap Zones are full (cf. Diabellstar the Black Witch)
function s.setfilter(c)
	return s.hlstfilter(c) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=Duel.SelectMatchingCard(tp,s.setfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then Duel.SSet(tp,tc) end
end
--(3)
--your face-up "Amazoness" monster (this card included: no "other") battling an opponent's monster;
--a direct attack has no opponent's monster (cf. Amazoness Golden Whip Master, Rookie Warrior Lady)
function s.indcon(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	return a and d and a:IsFaceup() and a:IsSetCard(0x4)
end
function s.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--"both battling monsters": the attacker and the attack target still in the battle, whoever controls them
	--(cf. Overexaggeration); does not need this card on the field at resolution
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget()):Filter(Card.IsRelateToBattle,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
	--"also": applied even if a monster has left the battle (cf. Destiny HERO - Dreamer)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
