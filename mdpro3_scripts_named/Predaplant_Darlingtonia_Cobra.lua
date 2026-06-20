--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 捕食植物 蛇瓶草眼镜蛇  (ID: 61677004)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 3
-- ATK 1000 | DEF 1500
-- Setcode: 4339
--
-- Effect Text:
-- 这个卡名的效果在决斗中只能使用1次。
-- ①：这张卡用「捕食植物」怪兽的效果特殊召唤的场合才能发动。从卡组把1张「融合」魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--捕食植物ダーリング・コブラ
function c61677004.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61677004,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,61677004+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c61677004.thcon)
	e1:SetTarget(c61677004.thtg)
	e1:SetOperation(c61677004.thop)
	c:RegisterEffect(e1)
end
function c61677004.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)&TYPE_MONSTER~=0 and c:IsSpecialSummonSetCard(0x10f3)
end
function c61677004.thfilter(c)
	return c:IsSetCard(0x46) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c61677004.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61677004.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c61677004.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c61677004.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
