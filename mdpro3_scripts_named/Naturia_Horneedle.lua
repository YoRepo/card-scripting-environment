--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 自然黄蜂针  (ID: 84905691)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 1800 | DEF 100
-- Setcode: 42
--
-- Effect Text:
-- 对方对怪兽的特殊召唤成功时，把这张卡以外的自己场上表侧表示存在的1只名字带有「自然」的怪兽解放才能发动。那些怪兽破坏。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ホーストニードル
function c84905691.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84905691,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCost(c84905691.cost)
	e1:SetTarget(c84905691.target)
	e1:SetOperation(c84905691.operation)
	c:RegisterEffect(e1)
end
function c84905691.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c84905691.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local fe=Duel.IsPlayerAffectedByEffect(tp,29942771)
	local b1=fe and Duel.IsPlayerCanDiscardDeckAsCost(tp,2)
	local b2=Duel.CheckReleaseGroup(tp,c84905691.cfilter,1,e:GetHandler())
	if chk==0 then return b1 or b2 end
	if b1 and (not b2 or Duel.SelectYesNo(tp,fe:GetDescription())) then
		Duel.Hint(HINT_CARD,0,29942771)
		fe:UseCountLimit(tp)
		Duel.DiscardDeck(tp,2,REASON_COST)
	else
		local g=Duel.SelectReleaseGroup(tp,c84905691.cfilter,1,1,e:GetHandler())
		Duel.Release(g,REASON_COST)
	end
end
function c84905691.filter(c,e,tp)
	return c:IsSummonPlayer(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c84905691.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) and not eg:IsContains(e:GetHandler())
		and eg:IsExists(c84905691.filter,1,nil,nil,tp) end
	local g=eg:Filter(c84905691.filter,nil,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c84905691.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c84905691.filter,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
