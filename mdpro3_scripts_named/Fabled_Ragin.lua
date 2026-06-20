--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔轰神 雷吉恩  (ID: 47395382)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fiend
-- Level 5
-- ATK 2300 | DEF 1800
-- Setcode: 53
--
-- Effect Text:
-- 「魔轰神」调整＋调整以外的怪兽1只以上
-- ①：这张卡同调召唤时才能发动。自己直到手卡变成2张为止抽卡。
--[[ __CARD_HEADER_END__ ]]

--魔轟神レイジオン
function c47395382.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x35),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47395382,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c47395382.con)
	e1:SetTarget(c47395382.tg)
	e1:SetOperation(c47395382.op)
	c:RegisterEffect(e1)
end
function c47395382.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c47395382.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local h=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		return h<2 and Duel.IsPlayerCanDraw(tp,2-h)
	end
	local h=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2-h)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2-h)
end
function c47395382.op(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local h=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if h>=2 then return end
	Duel.Draw(p,2-h,REASON_EFFECT)
end
