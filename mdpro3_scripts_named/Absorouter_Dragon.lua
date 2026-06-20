--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 绝对路由龙  (ID: 67748760)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 1200 | DEF 2800
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有「弹丸」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡被送去墓地的场合才能发动。从卡组把1只「弹丸」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--アブソルーター・ドラゴン
function c67748760.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,67748760+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67748760.sprcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67748760,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,67748761)
	e2:SetTarget(c67748760.thtg)
	e2:SetOperation(c67748760.thop)
	c:RegisterEffect(e2)
end
function c67748760.sprfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x102)
end
function c67748760.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c67748760.sprfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c67748760.thfilter(c)
	return c:IsSetCard(0x102) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c67748760.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67748760.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c67748760.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c67748760.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
