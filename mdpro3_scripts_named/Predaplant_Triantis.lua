--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 捕食植物 黏菖蒲螳螂  (ID: 17825378)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Plant
-- Level 8
-- Pendulum Scales: L8 / R8
-- ATK 2400 | DEF 1000
-- Setcode: 4339
--
-- Effect Text:
-- （注：暂时无法正常使用）
--
-- ←8 【灵摆】 8→
-- ①：只要这张卡在灵摆区域存在，自己把暗属性融合怪兽融合召唤的场合，自己的灵摆区域存在的融合素材怪兽也能作为场上的怪兽来作为融合素材使用。
-- 【怪兽效果】
-- ①：这张卡成为融合召唤的素材，被送去墓地的场合或者表侧加入额外卡组的场合才能发动。选最多有自己场上的怪兽数量的场上的表侧表示怪兽。给那些怪兽各放置1个捕食指示物。有捕食指示物放置的2星以上的怪兽的等级
-- 变成1星。
--[[ __CARD_HEADER_END__ ]]

--捕食植物トリアンティス
--not fully implemented
function c17825378.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pzone fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_FUSION_MATERIAL)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_PZONE,0)
	e1:SetValue(c17825378.mtval)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c17825378.ctcon)
	e2:SetTarget(c17825378.cttg)
	e2:SetOperation(c17825378.ctop)
	c:RegisterEffect(e2)
end
function c17825378.mtval(e,c)
	if not c then return true end
	return true --c:IsAttribute(ATTRIBUTE_DARK)
end
function c17825378.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE+LOCATION_EXTRA) and r==REASON_FUSION and not c:IsReason(REASON_RETURN)
end
function c17825378.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and Duel.IsExistingMatchingCard(Card.IsCanAddCounter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,0x1041,1) end
end
function c17825378.ctop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,0x1041,1)
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
		local sg=g:Select(tp,1,ct,nil)
		local sc=sg:GetFirst()
		while sc do
			if sc:AddCounter(0x1041,1) and sc:GetLevel()>1 then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				e1:SetCondition(c17825378.lvcon)
				e1:SetValue(1)
				sc:RegisterEffect(e1)
			end
			sc=sg:GetNext()
		end
	end
end
function c17825378.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
