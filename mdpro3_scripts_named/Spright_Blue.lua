--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 卫星闪灵·蓝色喷流灵  (ID: 76145933)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Thunder
-- Level 2
-- ATK 1100 | DEF 1000
-- Setcode: 384
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有2星或2阶的怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡特殊召唤的场合才能发动。从卡组把「卫星闪灵·蓝色喷流灵」以外的1只「卫星闪灵」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--スプライト・ブルー
function c76145933.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,76145933+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c76145933.spcon)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,76145934)
	e2:SetTarget(c76145933.thtg)
	e2:SetOperation(c76145933.thop)
	c:RegisterEffect(e2)
end
function c76145933.filter(c)
	return (c:IsLevel(2) or c:IsRank(2)) and c:IsFaceup()
end
function c76145933.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c76145933.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c76145933.thfilter(c)
	return c:IsSetCard(0x180) and not c:IsCode(76145933) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c76145933.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c76145933.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c76145933.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c76145933.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
