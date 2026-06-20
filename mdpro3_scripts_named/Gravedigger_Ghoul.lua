--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 掘墓的食尸鬼  (ID: 82542267)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择对方的墓地1张到2张的怪兽卡。选择的卡从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--墓掘りグール
function c82542267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c82542267.target)
	e1:SetOperation(c82542267.activate)
	c:RegisterEffect(e1)
end
function c82542267.filter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function c82542267.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c82542267.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82542267.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c82542267.filter,tp,0,LOCATION_GRAVE,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),1-tp,LOCATION_GRAVE)
end
function c82542267.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
