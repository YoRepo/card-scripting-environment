--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 落大穴  (ID: 30127518)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方以表侧表示对2只以上的怪兽的特殊召唤成功时才能发动。那些怪兽全部送去墓地。并且再把和那些怪兽同名怪兽从对方的手卡·卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--落とし大穴
function c30127518.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c30127518.target)
	e1:SetOperation(c30127518.activate)
	c:RegisterEffect(e1)
end
function c30127518.cfilter(c,sp,e)
	return c:IsFaceup() and c:IsSummonPlayer(sp) and (not e or c:IsRelateToEffect(e))
end
function c30127518.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c30127518.cfilter,2,nil,1-tp) end
	local g=eg:Filter(c30127518.cfilter,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c30127518.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c30127518.cfilter,nil,1-tp,e)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local exg=Group.CreateGroup()
	local g1=Duel.GetOperatedGroup()
	local tc=g1:GetFirst()
	while tc do
		if tc:IsLocation(LOCATION_GRAVE) then
			local fg=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_DECK+LOCATION_HAND,nil,tc:GetCode())
			exg:Merge(fg)
		end
		tc=g1:GetNext()
	end
	Duel.BreakEffect()
	Duel.SendtoGrave(exg,REASON_EFFECT)
end
