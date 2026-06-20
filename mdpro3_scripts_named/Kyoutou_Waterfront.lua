--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 京塔 海滨地区  (ID: 56111151)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：每次场上的卡被送去墓地，每有1张给这张卡放置1个坏兽指示物（最多5个）。
-- ②：1回合1次，这张卡的坏兽指示物是3个以上的场合才能发动。自己从卡组把1只「坏兽」怪兽加入手卡。
-- ③：这张卡被效果破坏的场合，可以作为代替把这张卡1个坏兽指示物取除。
--[[ __CARD_HEADER_END__ ]]

--KYOUTOUウォーターフロント
function c56111151.initial_effect(c)
	c:EnableCounterPermit(0x37)
	c:SetCounterLimit(0x37,5)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c56111151.counter)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c56111151.thcon)
	e3:SetTarget(c56111151.thtg)
	e3:SetOperation(c56111151.thop)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTarget(c56111151.desreptg)
	e4:SetOperation(c56111151.desrepop)
	c:RegisterEffect(e4)
end
function c56111151.cfilter(c)
	return c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c56111151.counter(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c56111151.cfilter,nil)
	if ct>0 then
		e:GetHandler():AddCounter(0x37,ct,true)
	end
end
function c56111151.thfilter(c)
	return c:IsSetCard(0xd3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c56111151.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x37)>=3
end
function c56111151.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56111151.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c56111151.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c56111151.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c56111151.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_REPLACE)
		and e:GetHandler():IsCanRemoveCounter(tp,0x37,1,REASON_EFFECT) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c56111151.desrepop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x37,1,REASON_EFFECT)
end
