--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 娱乐伙伴 电话长角牛  (ID: 92170894)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴 电话长角牛」的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。从卡组把灵摆怪兽以外的1只「娱乐伙伴」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--EMロングフォーン・ブル
function c92170894.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92170894,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,92170894)
	e1:SetTarget(c92170894.thtg)
	e1:SetOperation(c92170894.tgop)
	c:RegisterEffect(e1)
end
function c92170894.thfilter(c)
	return c:IsSetCard(0x9f) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c92170894.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92170894.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92170894.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92170894.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
