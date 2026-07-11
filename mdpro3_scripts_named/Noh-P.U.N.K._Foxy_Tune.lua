--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Noh-P.U.N.K. Foxy Tune  (ID: 55920742)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 8
-- ATK 2300 | DEF 2600
-- Setcode: 0x171
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, when this card destroys an opponent's monster by battle: You can gain LP equal to
-- that monster's original ATK.
-- You can only use each of the following effects of "Noh-P.U.N.K. Foxy Tune" once per turn.
-- You can Tribute 1 "P.U.N.K." monster; Special Summon this card from your hand.
-- You can send this card from your hand or field to the GY; send 1 card from your hand to the GY, and
-- if you do, Special Summon 1 "P.U.N.K." monster from your Deck, except a Level 8 monster.
--[[ __CARD_HEADER_END__ ]]

--No－P.U.N.K.フォクシー・チューン
function c55920742.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55920742,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,55920742)
	e1:SetCost(c55920742.spcost)
	e1:SetTarget(c55920742.sptg)
	e1:SetOperation(c55920742.spop)
	c:RegisterEffect(e1)
	--Special Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55920742,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e2:SetCountLimit(1,55920743)
	e2:SetCost(c55920742.spcost1)
	e2:SetTarget(c55920742.sptg1)
	e2:SetOperation(c55920742.spop1)
	c:RegisterEffect(e2)
	--recover(battle)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(55920742,2))
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCountLimit(1)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c55920742.rctg)
	e3:SetOperation(c55920742.rcop)
	c:RegisterEffect(e3)
end
function c55920742.rfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0 and c:IsSetCard(0x171) and (c:IsFaceup() or c:IsControler(tp))
end
function c55920742.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c55920742.rfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c55920742.rfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c55920742.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c55920742.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c55920742.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c55920742.spfilter(c,e,tp)
	return c:IsSetCard(0x171) and not c:IsLevel(8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55920742.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c55920742.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c55920742.spop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,1,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		if Duel.SendtoGrave(tg,REASON_EFFECT)==0 or not tc:IsLocation(LOCATION_GRAVE) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c55920742.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c55920742.rctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local dam=bc:GetBaseAttack()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,dam)
end
function c55920742.rcop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
