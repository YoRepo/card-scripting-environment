--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 幻兽机 协和金翅鸟  (ID: 53451824)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Machine
-- Level 7
-- ATK 2400 | DEF 1200
-- Setcode: 4123
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 只要这张卡在场上表侧表示存在，自己场上的衍生物不会被战斗以及效果破坏。场上的这张卡被对方破坏送去墓地的场合，把自己场上的衍生物全部解放才能发动。从自己墓地选择1只4星以下的名字带有「幻兽机」的怪兽特殊
-- 召唤。
--[[ __CARD_HEADER_END__ ]]

--幻獣機コンコルーダ
function c53451824.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOKEN))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(53451824,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c53451824.spcon)
	e3:SetCost(c53451824.spcost)
	e3:SetTarget(c53451824.sptg)
	e3:SetOperation(c53451824.spop)
	c:RegisterEffect(e3)
end
function c53451824.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) and c:GetReasonPlayer()==1-tp
end
function c53451824.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_TOKEN)
	e:SetLabel(g:GetCount())
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsReleasable,nil)==g:GetCount() end
	Duel.Release(g,REASON_COST)
end
function c53451824.spfilter(c,e,tp)
	return c:IsSetCard(0x101b) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c53451824.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c53451824.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-e:GetLabel()+1
		and Duel.IsExistingTarget(c53451824.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c53451824.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c53451824.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
