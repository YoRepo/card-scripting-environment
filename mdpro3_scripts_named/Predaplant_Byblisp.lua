--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 捕食植物 腺毛草胡蜂  (ID: 44932065)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 1
-- ATK 0 | DEF 1900
-- Setcode: 4339
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡被送去墓地的场合才能发动。从卡组把「捕食植物 腺毛草胡蜂」以外的1只「捕食植物」怪兽加入手卡。
-- ②：这张卡在墓地存在，场上的怪兽有捕食指示物放置中的场合才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--捕食植物ビブリスプ
local s,id,o=GetID()
function c44932065.initial_effect(c)
	--Effect 1 : Search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44932065,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,44932065)
	e1:SetTarget(c44932065.thtg)
	e1:SetOperation(c44932065.thop)
	c:RegisterEffect(e1)
	--Effect 2 : Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44932065,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,44932065+o)
	e2:SetCondition(c44932065.spcon)
	e2:SetTarget(c44932065.sptg)
	e2:SetOperation(c44932065.spop)
	c:RegisterEffect(e2)
end
function c44932065.thfilter(c)
	return c:IsSetCard(0x10f3) and c:IsType(TYPE_MONSTER) and not c:IsCode(44932065) and c:IsAbleToHand()
end
function c44932065.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44932065.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44932065.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44932065.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c44932065.cfilter(c)
	return c:IsFaceup() and c:GetCounter(0x1041)>0
end
function c44932065.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44932065.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c44932065.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44932065.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
