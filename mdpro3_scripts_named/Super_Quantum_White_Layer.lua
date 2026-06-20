--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 超级量子战士 白光层  (ID: 73422829)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2400 | DEF 2400
-- Setcode: 4316
--
-- Effect Text:
-- 这个卡名的①②③的效果1回合各能使用1次。
-- ①：从手卡以及自己场上的表侧表示怪兽之中把1只光属性以外的「超级量子」怪兽送去墓地才能发动。这张卡从手卡守备表示特殊召唤。
-- ②：这张卡召唤·特殊召唤成功时才能发动。从卡组把1只「超级量子」怪兽送去墓地。这张卡的属性·等级变成和那只怪兽相同。
-- ③：这张卡被送去墓地的场合才能发动。从自己的卡组·墓地选1只「超级量子妖精 阿尔方」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--超量士ホワイトレイヤー
function c73422829.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73422829,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,73422829)
	e1:SetCost(c73422829.spcost)
	e1:SetTarget(c73422829.sptg)
	e1:SetOperation(c73422829.spop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73422829,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,73422830)
	e2:SetTarget(c73422829.tgtg)
	e2:SetOperation(c73422829.tgop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(73422829,2))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,73422831)
	e4:SetTarget(c73422829.thtg)
	e4:SetOperation(c73422829.thop)
	c:RegisterEffect(e4)
end
function c73422829.cfilter(c,tp)
	return c:IsNonAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_MONSTER) and c:IsSetCard(0xdc)
		and c:IsAbleToGraveAsCost() and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and Duel.GetMZoneCount(tp,c)>0
end
function c73422829.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73422829.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c73422829.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler(),tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c73422829.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c73422829.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c73422829.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xdc) and c:IsAbleToGrave()
end
function c73422829.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73422829.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c73422829.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,c73422829.tgfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) then
		local lv=tc:GetLevel()
		local att=tc:GetAttribute()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e2:SetValue(att)
		c:RegisterEffect(e2)
	end
end
function c73422829.thfilter(c)
	return c:IsCode(58753372) and c:IsAbleToHand()
end
function c73422829.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73422829.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c73422829.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c73422829.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
