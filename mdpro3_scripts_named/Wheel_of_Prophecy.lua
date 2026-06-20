--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 魔导兽士 鲁德  (ID: 65961085)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 2700 | DEF 1700
-- Setcode: 110
--
-- Effect Text:
-- 这张卡用魔法师族怪兽的效果特殊召唤成功时，选择从游戏中除外的自己的名字带有「魔导书」的魔法卡任意数量才能发动。选择的卡回到卡组，剩下的名字带有「魔导书」的魔法卡回到墓地。「魔导兽士
-- 鲁德」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--魔導獣士 ルード
function c65961085.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65961085,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,65961085)
	e1:SetCondition(c65961085.retcon)
	e1:SetTarget(c65961085.rettg)
	e1:SetOperation(c65961085.retop)
	c:RegisterEffect(e1)
end
function c65961085.retcon(e,tp,eg,ep,ev,re,r,rp)
	local typ,race=e:GetHandler():GetSpecialSummonInfo(SUMMON_INFO_TYPE,SUMMON_INFO_RACE)
	return typ&TYPE_MONSTER~=0 and race&RACE_SPELLCASTER~=0
end
function c65961085.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c65961085.rettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c65961085.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65961085.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c65961085.filter,tp,LOCATION_REMOVED,0,1,99,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c65961085.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL)
end
function c65961085.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(c65961085.filter2,tp,LOCATION_REMOVED,0,nil)
	if g2:GetCount()>0 then
		Duel.SendtoGrave(g2,REASON_EFFECT+REASON_RETURN)
	end
end
