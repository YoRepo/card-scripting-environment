--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 音响战士 钢琴  (ID: 31826057)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 900 | DEF 1300
-- Setcode: 4198
--
-- Effect Text:
-- 宣言1个种族，选择场上表侧表示存在的1只名字带有「音响战士」的怪兽发动。选择的怪兽变成宣言的种族。这个效果1回合只能使用1次。此外，宣言1个种族，可以把自己墓地存在的这张卡从游戏中除外，自己场上表侧表
-- 示存在的1只名字带有「音响战士」的怪兽变成宣言的种族。
--[[ __CARD_HEADER_END__ ]]

--音響戦士ピアーノ
function c31826057.initial_effect(c)
	--race change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31826057,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c31826057.target1)
	e1:SetOperation(c31826057.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31826057,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c31826057.target2)
	e2:SetOperation(c31826057.operation)
	c:RegisterEffect(e2)
end
function c31826057.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1066)
end
function c31826057.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c31826057.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c31826057.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c31826057.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL-g:GetFirst():GetRace())
	e:SetLabel(rc)
end
function c31826057.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c31826057.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c31826057.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c31826057.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL-g:GetFirst():GetRace())
	e:SetLabel(rc)
end
function c31826057.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end
