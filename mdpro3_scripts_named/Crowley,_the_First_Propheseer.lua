--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔导原典 克劳利  (ID: 50756327)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Spellcaster
-- ATK 1000 | LINK
-- Setcode: 110
--
-- Effect Text:
-- 魔法师族怪兽2只
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤成功的场合才能发动。从卡组把「魔导书」卡3种类给对方观看，对方从那之中随机选1张。那1张卡加入自己手卡，剩下的卡回到卡组。
-- ②：只要这张卡在怪兽区域存在，自己在5星以上的魔法师族怪兽召唤的场合需要的解放可以不用。这个效果1回合只能适用1次。
--[[ __CARD_HEADER_END__ ]]

--魔導原典 クロウリー
function c50756327.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_SPELLCASTER),2,2)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50756327,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,50756327)
	e1:SetCondition(c50756327.thcon)
	e1:SetTarget(c50756327.thtg)
	e1:SetOperation(c50756327.thop)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50756327,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c50756327.ntcon)
	e2:SetTarget(c50756327.nttg)
	c:RegisterEffect(e2)
end
function c50756327.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c50756327.thfilter(c)
	return c:IsSetCard(0x106e) and c:IsAbleToHand()
end
function c50756327.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local dg=Duel.GetMatchingGroup(c50756327.thfilter,tp,LOCATION_DECK,0,nil)
		return dg:GetClassCount(Card.GetCode)>=3
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c50756327.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c50756327.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetClassCount(Card.GetCode)>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg1=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
		Duel.ConfirmCards(1-tp,sg1)
		local cg=sg1:RandomSelect(1-tp,1)
		local tc=cg:GetFirst()
		tc:SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
	end
end
function c50756327.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c50756327.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_SPELLCASTER)
end
