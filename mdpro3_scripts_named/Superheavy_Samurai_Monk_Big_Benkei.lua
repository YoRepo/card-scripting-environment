--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 超重僧兵 大弁庆-K  (ID: 19510093)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 1000 | DEF 3500
-- Setcode: 154
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：自己场上有「超重武者」怪兽存在的场合才能发动。从卡组把1只「超重武者装留」怪兽加入手卡。
-- 【怪兽效果】
-- 这个卡名在规则上也当作「超重武者」卡使用。这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：自己墓地没有魔法·陷阱卡存在的场合才能发动。从手卡·卡组把1只「超重武者 大弁庆-K」送去墓地，这张卡从手卡特殊召唤。
-- ②：这张卡作为同调素材表侧表示加入额外卡组的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--超重僧兵ビッグベン－K
function c19510093.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19510093,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,19510093)
	e1:SetCondition(c19510093.thcon)
	e1:SetTarget(c19510093.thtg)
	e1:SetOperation(c19510093.thop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19510093,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,19510094)
	e2:SetCondition(c19510093.spcon)
	e2:SetTarget(c19510093.sptg)
	e2:SetOperation(c19510093.spop)
	c:RegisterEffect(e2)
	--move
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,19510095)
	e3:SetCondition(c19510093.pencon)
	e3:SetTarget(c19510093.pentg)
	e3:SetOperation(c19510093.penop)
	c:RegisterEffect(e3)
end
function c19510093.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsSetCard),tp,LOCATION_MZONE,0,1,nil,0x9a)
end
function c19510093.thfilter(c)
	return c:IsSetCard(0x109a) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c19510093.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19510093.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c19510093.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c19510093.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c19510093.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c19510093.tgfilter(c)
	return c:IsCode(3117804) and c:IsAbleToGrave()
end
function c19510093.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c19510093.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c19510093.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c19510093.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	if #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	if Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE)
		and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c19510093.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_EXTRA) and c:IsFaceup() and r==REASON_SYNCHRO
end
function c19510093.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c19510093.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
