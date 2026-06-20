--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 武神器-生  (ID: 42551040)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1100 | DEF 1900
-- Setcode: 136
--
-- Effect Text:
-- 自己的主要阶段时，自己场上有名字带有「武神」的怪兽存在的场合，把墓地的这张卡从游戏中除外，选择对方场上表侧攻击表示存在的1只怪兽才能发动。选择的怪兽变成表侧守备表示，那个守备力直到结束阶段时变成0。
--[[ __CARD_HEADER_END__ ]]

--武神器－イクタ
function c42551040.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42551040,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c42551040.poscon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c42551040.postg)
	e1:SetOperation(c42551040.posop)
	c:RegisterEffect(e1)
end
function c42551040.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88)
end
function c42551040.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c42551040.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c42551040.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c42551040.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c42551040.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42551040.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c42551040.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c42551040.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
