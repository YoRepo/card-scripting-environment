--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 女武神三女  (ID: 3026686)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1000 | DEF 1600
-- Setcode: 290
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把「女武神三女」以外的1张「女武神」卡加入手卡。
-- ②：这张卡的攻击力上升除外的对方怪兽数量×200。
--[[ __CARD_HEADER_END__ ]]

--ワルキューレ・ドリット
function c3026686.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3026686,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,3026686)
	e1:SetTarget(c3026686.thtg)
	e1:SetOperation(c3026686.thop)
	c:RegisterEffect(e1)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk/def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c3026686.atkvalue)
	c:RegisterEffect(e4)
end
function c3026686.thfilter(c)
	return c:IsSetCard(0x122) and c:IsAbleToHand() and not c:IsCode(3026686)
end
function c3026686.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3026686.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c3026686.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3026686.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c3026686.rmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c3026686.atkvalue(e,c)
	return Duel.GetMatchingGroupCount(c3026686.rmfilter,c:GetControler(),0,LOCATION_REMOVED,nil)*200
end
