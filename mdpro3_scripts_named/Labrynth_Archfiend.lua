--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Labrynth Archfiend  (ID: 48745395)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2000 | DEF 2800
-- Setcode: 0x17e, 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 400 ATK for each Normal Trap with a different name in your GY.
-- Your opponent's monsters cannot target Fiend monsters for attacks, except "Labrynth Archfiend".
-- You can only use each of the following effects of "Labrynth Archfiend" once per turn.
-- If a Trap Card is activated (except during the Damage Step): You can Special Summon this card from
-- your hand.
-- If this card is Special Summoned: You can Set 1 Normal Trap from your Deck that can only be
-- activated when an attack is declared.
--[[ __CARD_HEADER_END__ ]]

--白銀の城の魔神像
function c48745395.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48745395,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,48745395)
	e1:SetCondition(c48745395.spcon)
	e1:SetTarget(c48745395.sptg)
	e1:SetOperation(c48745395.spop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,48745396)
	e2:SetTarget(c48745395.sttg)
	e2:SetOperation(c48745395.stop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetValue(c48745395.atkval)
	c:RegisterEffect(e3)
	--battle target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetValue(c48745395.atklimit)
	c:RegisterEffect(e4)
end
function c48745395.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end
function c48745395.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c48745395.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c48745395.stfilter(c)
	local te=c:GetActivateEffect()
	return c:GetType()==TYPE_TRAP and te and te:GetCode()==EVENT_ATTACK_ANNOUNCE and c:IsSSetable()
end
function c48745395.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48745395.stfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c48745395.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c48745395.stfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c48745395.atkfilter(c)
	return c:GetType()==TYPE_TRAP
end
function c48745395.atkval(e,c)
	local g=Duel.GetMatchingGroup(c48745395.atkfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetCode)*400
end
function c48745395.atklimit(e,c)
	return c:IsFaceup() and not c:IsCode(48745395) and c:IsRace(RACE_FIEND)
end
