--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 同盟编队  (ID: 26931058)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从下面效果选择1个发动：
-- ●选择自己场上表侧表示存在的1只同盟怪兽，给自己场上表侧表示存在的可以装备的怪兽装备。
-- ●把自己场上存在的1只当作装备卡使用的同盟怪兽的装备解除，在自己场上表侧攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--フォーメーション・ユニオン
function c26931058.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c26931058.eftg)
	e1:SetOperation(c26931058.efop)
	c:RegisterEffect(e1)
end
c26931058.has_text_type=TYPE_UNION
function c26931058.filter1(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_UNION)
		and Duel.IsExistingMatchingCard(c26931058.filter2,tp,LOCATION_MZONE,0,1,c,c)
end
function c26931058.filter2(c,ec)
	return c:IsFaceup() and ec:CheckUnionTarget(c) and aux.CheckUnionEquip(ec,c)
end
function c26931058.filter3(c,e,tp)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_UNION_STATUS) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c26931058.eftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if e:GetLabel()==0 then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c26931058.filter1(chkc,tp)
		else return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and c26931058.filter3(chkc,e,tp) end
	end
	local b1=Duel.IsExistingTarget(c26931058.filter1,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	local b2=Duel.IsExistingTarget(c26931058.filter3,tp,LOCATION_SZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(26931058,0),aux.Stringid(26931058,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(26931058,0))
	else op=Duel.SelectOption(tp,aux.Stringid(26931058,1))+1 end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(0)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26931058,2))
		Duel.SelectTarget(tp,c26931058.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c26931058.filter3,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
end
function c26931058.efop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local tc=Duel.GetFirstTarget()
		if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c26931058.filter2,tp,LOCATION_MZONE,0,1,1,tc,tc)
		local ec=g:GetFirst()
		if ec and Duel.Equip(tp,tc,ec,false) then
			aux.SetUnionState(tc)
		end
	else
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsRelateToEffect(e) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end
