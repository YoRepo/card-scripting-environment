--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Exploderokket Dragon  (ID: 31353051)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 7
-- ATK 2000 | DEF 2000
-- Setcode: 0x102
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Link Monster's effect is activated that targets this face-up card on the field (Quick
-- Effect): You can destroy this card, then each player takes 2000 damage.
-- During the End Phase, if this card is in the GY because it was destroyed on the field by battle or
-- card effect and sent there this turn: You can Special Summon 1 "Rokket" monster from your Deck,
-- except "Exploderokket Dragon".
-- You can only use each effect of "Exploderokket Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--エクスプロードヴァレット・ドラゴン
function c31353051.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31353051,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,31353051)
	e1:SetCondition(c31353051.descon)
	e1:SetTarget(c31353051.destg)
	e1:SetOperation(c31353051.desop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c31353051.regop)
	c:RegisterEffect(e2)
end
function c31353051.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	return re:IsActiveType(TYPE_LINK)
end
function c31353051.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,2000)
end
function c31353051.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		Duel.Damage(tp,2000,REASON_EFFECT,true)
		Duel.Damage(1-tp,2000,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
function c31353051.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(31353051,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,31353052)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c31353051.sptg)
		e1:SetOperation(c31353051.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c31353051.spfilter(c,e,tp)
	return c:IsSetCard(0x102) and not c:IsCode(31353051) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c31353051.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c31353051.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c31353051.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c31353051.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
