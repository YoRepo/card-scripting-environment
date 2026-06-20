--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 大慈大悲的机械天使  (ID: 64442155)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 292
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己的手卡·场上1只「电子化天使」仪式怪兽解放才能发动。自己从卡组抽2张，那之后选1张手卡回到卡组最下面。这张卡的发动后，直到回合结束时自己不是仪式怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--慈悲深き機械天使
function c64442155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,64442155+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c64442155.cost)
	e1:SetTarget(c64442155.target)
	e1:SetOperation(c64442155.activate)
	c:RegisterEffect(e1)
end
function c64442155.costfilter(c)
	return c:IsSetCard(0x2093) and c:GetType()&0x81==0x81
end
function c64442155.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,c64442155.costfilter,1,REASON_COST,true,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectReleaseGroupEx(tp,c64442155.costfilter,1,1,REASON_COST,true,nil)
	Duel.Release(g,REASON_COST)
end
function c64442155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c64442155.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,1,1,nil)
		Duel.SendtoDeck(sg,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c64442155.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c64442155.splimit(e,c)
	return c:GetOriginalType()&0x81~=0x81
end
