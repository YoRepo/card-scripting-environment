--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 堕天使 乌科巴克  (ID: 92807548)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 3
-- ATK 700 | DEF 1000
-- Setcode: 239
--
-- Effect Text:
-- 「堕天使 乌科巴克」的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把1张「堕天使」卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--堕天使ユコバック
function c92807548.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92807548,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,92807548)
	e1:SetTarget(c92807548.tgtg)
	e1:SetOperation(c92807548.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c92807548.tgfilter(c)
	return c:IsSetCard(0xef) and c:IsAbleToGrave()
end
function c92807548.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92807548.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c92807548.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c92807548.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
