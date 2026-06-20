--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 同调素材  (ID: 14507213)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 23
--
-- Effect Text:
-- 选择对方场上表侧表示存在的1只怪兽发动。这个回合自己同调召唤的场合，可以把选择的怪兽作为同调素材。这张卡发动的回合，自己不能进行战斗阶段。
--[[ __CARD_HEADER_END__ ]]

--シンクロ・マテリアル
function c14507213.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c14507213.cost)
	e1:SetTarget(c14507213.target)
	e1:SetOperation(c14507213.activate)
	c:RegisterEffect(e1)
end
function c14507213.filter(c)
	return c:IsFaceup() and c:IsCanBeSynchroMaterial()
end
function c14507213.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c14507213.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c14507213.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14507213.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c14507213.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c14507213.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_SYNCHRO_MATERIAL)
		e1:SetOwnerPlayer(tp)
		e1:SetValue(c14507213.matval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c14507213.matval(e,c)
	return c:IsControler(e:GetOwnerPlayer())
end
