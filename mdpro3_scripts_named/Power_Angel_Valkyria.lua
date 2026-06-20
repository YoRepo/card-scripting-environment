--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 力天使 女武神  (ID: 89055154)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1800 | DEF 1050
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己把怪兽的效果·魔法·陷阱卡的发动无效的场合发动。从卡组把1只天使族·光属性怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--力天使ヴァルキリア
function c89055154.initial_effect(c)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89055154,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_CHAIN_NEGATED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,89055154)
	e3:SetCondition(c89055154.thcon)
	e3:SetTarget(c89055154.thtg)
	e3:SetOperation(c89055154.thop)
	c:RegisterEffect(e3)
end
function c89055154.thcon(e,tp,eg,ep,ev,re,r,rp)
	local dp=Duel.GetChainInfo(ev,CHAININFO_DISABLE_PLAYER)
	return dp==tp and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c89055154.thfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c89055154.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c89055154.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c89055154.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
