--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 装备喷射球  (ID: 62878208)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 战斗阶段中才能发动。选择自己场上表侧攻击表示存在的怪兽装备的1张装备卡和对方场上存在的1只表侧攻击表示的怪兽，把选择的装备卡给选择的对方怪兽装备。那之后，选择的装备卡装备过的自己怪兽和选择的对方怪兽进
-- 行战斗进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--イクイップ・シュート
function c62878208.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c62878208.eqcon)
	e1:SetTarget(c62878208.eqtg)
	e1:SetOperation(c62878208.eqop)
	c:RegisterEffect(e1)
end
function c62878208.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c62878208.filter1(c,e,tp)
	local ec=c:GetEquipTarget()
	return ec and ec:IsControler(tp) and ec:IsPosition(POS_FACEUP_ATTACK)
		and Duel.IsExistingTarget(c62878208.filter2,tp,0,LOCATION_MZONE,1,nil,c)
end
function c62878208.filter2(c,ec)
	return c:IsPosition(POS_FACEUP_ATTACK) and ec:CheckEquipTarget(c)
end
function c62878208.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c62878208.filter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62878208,0))
	local g1=Duel.SelectTarget(tp,c62878208.filter1,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,e,tp)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	local g2=Duel.SelectTarget(tp,c62878208.filter2,tp,0,LOCATION_MZONE,1,1,nil,g1:GetFirst())
end
function c62878208.eqop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetLabelObject()
	local eqc=eq:GetEquipTarget()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if eq==tc then tc=g:GetNext() end
	if eqc and eq:IsRelateToEffect(e) then
		if not Duel.Equip(tp,eq,tc) then return end
		Duel.BreakEffect()
		local a=eqc
		local d=tc
		if Duel.GetTurnPlayer()~=tp then
			a=tc
			d=eqc
		end
		if a:IsAttackable() and not a:IsImmuneToEffect(e) and not d:IsImmuneToEffect(e) then
			Duel.CalculateDamage(a,d,true)
		end
	end
end
