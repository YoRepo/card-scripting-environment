--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 北极天熊-大黑熊  (ID: 54700519)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level 8
-- ATK 2400 | DEF 700
-- Setcode: 355
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，从手卡把这张卡以外的1只7星以上的怪兽解放才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己若非持有等级的怪兽则不能特殊召唤。
-- ②：自己场上有其他的「北极天熊」怪兽存在的状态，这张卡特殊召唤成功的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ベアルクティ－メガタナス
function c54700519.initial_effect(c)
	--spsummon
	local e1=aux.AddUrsarcticSpSummonEffect(c)
	e1:SetDescription(aux.Stringid(54700519,0))
	e1:SetCountLimit(1,54700519)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54700519,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,54700520)
	e2:SetCondition(c54700519.poscon)
	e2:SetTarget(c54700519.postg)
	e2:SetOperation(c54700519.posop)
	c:RegisterEffect(e2)
end
function c54700519.confilter(c)
	return c:IsFaceup() and c:IsSetCard(0x163)
end
function c54700519.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c54700519.confilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c54700519.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c54700519.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c54700519.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54700519.posfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c54700519.posfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c54700519.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
