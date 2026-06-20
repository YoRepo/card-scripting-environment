--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恶魔娘 莉莉丝  (ID: 23898021)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 2000 | DEF 0
-- Setcode: 372
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：召唤的这张卡的原本攻击力变成1000。
-- ②：把自己场上1只暗属性怪兽解放才能发动。从卡组把3张通常陷阱卡给对方观看，对方从那之中随机选1张。那1张卡在自己场上盖放，剩下的卡回到卡组。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--悪魔嬢リリス
function c23898021.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_COST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetOperation(c23898021.regop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,23898021)
	e2:SetCost(c23898021.thcost)
	e2:SetTarget(c23898021.thtg)
	e2:SetOperation(c23898021.thop)
	c:RegisterEffect(e2)
end
function c23898021.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
function c23898021.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,nil,ATTRIBUTE_DARK) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_DARK)
	Duel.Release(g,REASON_COST)
end
function c23898021.thfilter(c)
	return c:GetType()==TYPE_TRAP and c:IsSSetable()
end
function c23898021.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c23898021.thfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c23898021.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23898021.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SET)
		local tg=sg:RandomSelect(1-tp,1)
		Duel.ShuffleDeck(tp)
		Duel.SSet(tp,tg,tp,false)
	end
end
