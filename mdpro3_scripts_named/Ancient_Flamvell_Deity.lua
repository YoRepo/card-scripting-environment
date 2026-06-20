--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 古代炎狱之神  (ID: 26304459)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Pyro
-- Level 7
-- ATK 2500 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 炎属性调整＋调整以外的炎族怪兽1只以上
-- 这张卡同调召唤成功时，选择最多有对方手卡数量的对方墓地存在的卡从游戏中除外。这张卡的攻击力上升这个效果除外的卡数量×200的数值。
--[[ __CARD_HEADER_END__ ]]

--エンシェント・ゴッド・フレムベル
function c26304459.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),aux.NonTuner(Card.IsRace,RACE_PYRO),1)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26304459,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c26304459.remcon)
	e1:SetTarget(c26304459.remtg)
	e1:SetOperation(c26304459.remop)
	c:RegisterEffect(e1)
end
function c26304459.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c26304459.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_GRAVE)
end
function c26304459.remop(e,tp,eg,ep,ev,re,r,rp)
	local ht=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ht==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,ht,nil)
	local c=e:GetHandler()
	if rg:GetCount()>0 then
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(rg:GetCount()*200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
