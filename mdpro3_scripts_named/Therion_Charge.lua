--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 兽带斗神突击  (ID: 57285770)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 377
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·魔法与陷阱区域（表侧表示）把1张「兽带斗神突击」以外的「兽带斗神」卡或者「无尽机关 银星系统」送去墓地才能发动。自己抽2张。
--[[ __CARD_HEADER_END__ ]]

--セリオンズ・チャージ
function c57285770.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57285770+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c57285770.cost)
	e1:SetTarget(c57285770.target)
	e1:SetOperation(c57285770.activate)
	c:RegisterEffect(e1)
end
function c57285770.costfilter(c)
	return (c:IsSetCard(0x179) or c:IsCode(21887075)) and not c:IsCode(57285770) and c:IsAbleToGraveAsCost()
		and ((c:IsFaceup() and c:GetSequence()<5) or not c:IsLocation(LOCATION_SZONE))
end
function c57285770.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57285770.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c57285770.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c57285770.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c57285770.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
