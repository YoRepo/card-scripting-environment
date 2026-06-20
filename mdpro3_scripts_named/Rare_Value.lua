--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 珍稀价值  (ID: 60876124)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己的魔法与陷阱区域有「宝玉兽」卡2张以上存在的场合才能发动。自己的魔法与陷阱区域1张「宝玉兽」卡由对方选出。对方选的卡送去墓地，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--レア・ヴァリュー
function c60876124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c60876124.condition)
	e1:SetTarget(c60876124.target)
	e1:SetOperation(c60876124.activate)
	c:RegisterEffect(e1)
end
function c60876124.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034)
end
function c60876124.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c60876124.filter,tp,LOCATION_SZONE,0,2,nil)
end
function c60876124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c60876124.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c60876124.filter,tp,LOCATION_SZONE,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
		if sg:GetFirst():IsLocation(LOCATION_GRAVE) then
			Duel.Draw(tp,2,REASON_EFFECT)
		end
	end
end
