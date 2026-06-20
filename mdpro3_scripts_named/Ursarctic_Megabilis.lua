--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 北极天熊-大灰熊  (ID: 81108658)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level 8
-- ATK 2800 | DEF 700
-- Setcode: 355
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，从手卡把这张卡以外的1只7星以上的怪兽解放才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己若非持有等级的怪兽则不能特殊召唤。
-- ②：自己场上有其他的「北极天熊」怪兽存在的状态，这张卡特殊召唤成功的场合，以对方墓地1张卡为对象才能发动。那张卡除外。
--[[ __CARD_HEADER_END__ ]]

--ベアルクティ－メガビリス
function c81108658.initial_effect(c)
	--spsummon
	local e1=aux.AddUrsarcticSpSummonEffect(c)
	e1:SetDescription(aux.Stringid(81108658,0))
	e1:SetCountLimit(1,81108658)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81108658,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,81108659)
	e2:SetCondition(c81108658.rmcon)
	e2:SetTarget(c81108658.rmtg)
	e2:SetOperation(c81108658.rmop)
	c:RegisterEffect(e2)
end
function c81108658.confilter(c)
	return c:IsFaceup() and c:IsSetCard(0x163)
end
function c81108658.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c81108658.confilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c81108658.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c81108658.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
