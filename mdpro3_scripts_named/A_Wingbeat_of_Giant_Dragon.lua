--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 巨龙振翅  (ID: 28596933)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：选自己场上1只5星以上的龙族怪兽回到持有者手卡，场上的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--巨竜の羽ばたき
function c28596933.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c28596933.target)
	e1:SetOperation(c28596933.activate)
	c:RegisterEffect(e1)
end
function c28596933.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsLevelAbove(5) and c:IsAbleToHand()
end
function c28596933.dfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c28596933.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28596933.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c28596933.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c28596933.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c28596933.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c28596933.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		local sg=Duel.GetMatchingGroup(c28596933.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
