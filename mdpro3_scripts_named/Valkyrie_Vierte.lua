--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 女武神四女  (ID: 81558967)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 1400 | DEF 1400
-- Setcode: 290
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。把这张卡以外的自己场上的「女武神」怪兽数量的卡从自己卡组上面翻开。那之中有通常魔法·通常陷阱卡的场合，选那之内的1张加入手卡，剩下的卡全部送去墓地。没有的场合，翻开的卡全部回
-- 到卡组。
-- ②：这张卡被战斗破坏送去墓地时才能发动。从卡组把1只「女武神」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ワルキューレ・フィアット
function c81558967.initial_effect(c)
	--deck search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81558967,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81558967)
	e1:SetTarget(c81558967.target)
	e1:SetOperation(c81558967.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81558967,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCountLimit(1,81558968)
	e2:SetCondition(c81558967.spcon)
	e2:SetTarget(c81558967.sptg)
	e2:SetOperation(c81558967.spop)
	c:RegisterEffect(e2)
end
function c81558967.ctfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x122)
end
function c81558967.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c81558967.ctfilter,tp,LOCATION_MZONE,0,e:GetHandler())
		if ct==0 or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<ct then return false end
		local g=Duel.GetDecktopGroup(tp,ct)
		return g:FilterCount(Card.IsAbleToHand,nil)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c81558967.thfilter(c)
	return c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP
end
function c81558967.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c81558967.ctfilter,tp,LOCATION_MZONE,0,e:GetHandler())
	if ct==0 then return end
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.ConfirmDecktop(tp,ct)
	local tg=g:Filter(c81558967.thfilter,nil)
	if tg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tc=tg:Select(tp,1,1,nil):GetFirst()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(tc,REASON_RULE)
		end
		g:RemoveCard(tc)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.ShuffleDeck(tp)
	end
end
function c81558967.spfilter(c,e,tp)
	return c:IsSetCard(0x122) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81558967.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c81558967.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81558967.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c81558967.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81558967.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
