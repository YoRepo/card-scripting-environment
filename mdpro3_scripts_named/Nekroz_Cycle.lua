--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 影灵衣的返魂术  (ID: 97211663)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 180
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从自己的手卡·墓地把1只「影灵衣」仪式怪兽仪式召唤。
-- ②：自己场上没有怪兽存在的场合，从自己墓地把1只「影灵衣」怪兽和这张卡除外才能发动。从卡组把1张「影灵衣」魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影霊衣の反魂術
function c97211663.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcEqual2(c,c97211663.filter,LOCATION_HAND+LOCATION_GRAVE,nil,nil,true)
	e1:SetCountLimit(1,97211663)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c97211663.thcon)
	e2:SetCost(c97211663.thcost)
	e2:SetTarget(c97211663.thtg)
	e2:SetOperation(c97211663.thop)
	c:RegisterEffect(e2)
end
function c97211663.filter(c)
	return c:IsSetCard(0xb4)
end
function c97211663.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c97211663.cfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c97211663.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c97211663.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c97211663.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c97211663.thfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c97211663.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97211663.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c97211663.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c97211663.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
