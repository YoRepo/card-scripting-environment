--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 爬虫妖女守卫者  (ID: 43002864)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 0 | DEF 2000
-- Setcode: 60
--
-- Effect Text:
-- 自己场上存在的这张卡被破坏送去墓地时，从自己卡组把1只名字带有「爬虫妖」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--レプティレス・ガードナー
function c43002864.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43002864,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c43002864.condition)
	e1:SetTarget(c43002864.target)
	e1:SetOperation(c43002864.operation)
	c:RegisterEffect(e1)
end
function c43002864.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
end
function c43002864.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c43002864.filter(c)
	return c:IsSetCard(0x3c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c43002864.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c43002864.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
