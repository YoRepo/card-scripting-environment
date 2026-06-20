--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔轰神兽 尤尼科  (ID: 44155002)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 2300 | DEF 1000
-- Setcode: 53
--
-- Effect Text:
-- 「魔轰神」调整＋调整以外的怪兽1只以上
-- ①：只要这张卡在怪兽区域存在并是双方手卡相同数量，对方发动的魔法·陷阱·怪兽的效果无效化并破坏。
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣ユニコール
function c44155002.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x35),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--disable and destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetOperation(c44155002.disop)
	c:RegisterEffect(e1)
end
function c44155002.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND) then return end
	local rc=re:GetHandler()
	if Duel.NegateEffect(ev,true) and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
